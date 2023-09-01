"use client"

import CustomButton from "./customButton";
import { useState, useTransition } from "react";
import { usePathname, useRouter } from "next/navigation";
import Link from "next/link";
import { authLogin } from "@/lib/authentication";
import { authLogout } from "@/lib/authentication";

export default function LoginSection ({ response }) {

    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [errors, setErrors] = useState(null)

    const [isPending, startTransition] = useTransition()

    const router = useRouter()

    const path = usePathname()

    async function handleSubmit(e){

        e.preventDefault()

        const res = await authLogin(email, password)

        if(res?.errors){
            setErrors(res.errors)
            setPassword('')
        }

        if(res === 200){
            router.push('/posts', { scroll: false })
        }

    }

    async function logoutHandle(){

        const res = await authLogout()

        if(res === 200){
            router.push('/')
        }

    }

    if(response === 200){

        if(email.length > 0 && password.length > 0){
            setEmail('')
            setPassword('')
        }

        return (
            <button
                onClick={e => startTransition(() => logoutHandle(e))}
                className="text-xl hover:underline hover:text-red-700"
            >
                Logout
            </button>
        )

    }

    if(path !== '/'){
        return (
            <Link
                href="/"
                className="text-xl hover:underline hover:text-blue-800"
            >
                Register/Login
            </Link>
        )
    }

    return (
        <div className="flex space-x-3">

            <form 
                className="flex flex-row space-x-2 text-base"
                onSubmit={e => startTransition(() => handleSubmit(e))}
            >

                <div className="flex flex-col w-[15rem]">

                    <label>
                        Email
                    </label>

                    <input 
                        type="email"
                        value={email}
                        onChange={e => setEmail(e.target.value)}
                        className="px-1 rounded-lg"
                    />

                </div>

                <div className="flex flex-col">

                    <div className="flex flex-row space-x-2">

                        <div className="flex flex-col">

                            <label>
                                Password
                            </label>

                            <input 
                                type="password"
                                value={password}
                                onChange={e => setPassword(e.target.value)}
                                className="px-1 rounded-lg w-[15rem]"
                            />

                        </div>

                        <CustomButton
                            addStyles="border-green-500 bg-green-200 px-2 mt-auto"
                            disabled={isPending}
                            tabIndex={-1}
                        >
                            Login
                        </CustomButton>

                    </div>

                    { errors !== null && <span className="text-xs text-red-800 mt-1"> { errors.password[0] } </span> }

                </div>

            </form>

        </div>
    )
}