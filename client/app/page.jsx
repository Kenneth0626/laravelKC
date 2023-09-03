"use client"

import CustomButton from "@/components/customButton";
import LabelInput from "@/components/labelInput";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useState, useTransition } from "react";
import { storeUser } from "@/lib/authentication";

export default function RegisterSection () {

    const [username, setUsername] = useState('')
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [passwordConfirmation, setPasswordConfirmation] = useState('')
    const [errors, setErrors] = useState('')

    const [isPending, startTransition] = useTransition()

    const router = useRouter()

    async function handleSubmit(e){

        e.preventDefault()

        const res = await storeUser(username, email, password, passwordConfirmation)

        if(res?.errors){
            setErrors(res.errors)
            setPassword('')
            setPasswordConfirmation('') 
        }

        if(res === 200){
            router.push("/posts")
        }

    }

    return (
        <main className="pt-[8rem] px-[30rem] w-full">

            <div className="bg-slate-400 border-4 border-black rounded-lg p-4">
                
                <div className="flex justify-between">

                    <h1 className="text-4xl">
                        Register
                    </h1>

                    <Link 
                        href={isPending ? "/" : "/posts"}
                        scroll={false}
                        className="text-base mt-auto hover:underline hover:text-blue-700"
                    >
                        or View Posts
                    </Link>

                </div>
                
                <hr className="border-black border-2 rounded-full my-[1rem]" />

                <form 
                    onSubmit={e => startTransition(() => handleSubmit(e))}
                    className="flex flex-col space-y-3"
                >
                    
                    <LabelInput 
                        label="Username"
                        type="text"
                        value={username}
                        onChange={e => setUsername(e.target.value)}
                        placeholder="abc123"
                        wrapStyle="space-y-[0.1rem]"
                        errors={errors?.username ? errors.username[0] : null}
                        labelStyle="text-2xl"
                        inputStyle="border-slate-300"
                        errorStyle="text-xs"
                    />

                    <LabelInput 
                        label="Email"
                        type="email"
                        value={email}
                        onChange={e => setEmail(e.target.value)}
                        placeholder="abc@xyz.com"
                        wrapStyle="space-y-[0.1rem]"
                        errors={errors?.email ? errors.email[0] : null}
                        labelStyle="text-2xl"
                        inputStyle="border-slate-300"
                        errorStyle="text-xs"
                    />

                    <LabelInput 
                        label="Password"
                        type="password"
                        value={password}
                        onChange={e => setPassword(e.target.value)}
                        wrapStyle="space-y-[0.1rem]"
                        errors={errors?.password ? errors.password[0] : null}
                        labelStyle="text-2xl"
                        inputStyle="border-slate-300"
                        errorStyle="text-xs"
                    />

                    <LabelInput 
                        label="Confirm Password"
                        type="password"
                        value={passwordConfirmation}
                        onChange={e => setPasswordConfirmation(e.target.value)}
                        wrapStyle="space-y-[0.1rem]"
                        labelStyle="text-2xl"
                        inputStyle="border-slate-300"
                    />

                    <CustomButton
                        addStyles="text-xl border-green-500 bg-green-200 w-fit p-2 self-end"
                        disabled={isPending}
                        tabIndex={-1}
                    >
                        Register
                    </CustomButton>

                </form>

            </div>
            
        </main>
    )
}