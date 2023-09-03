import LoginSection from "./loginSection";
import Link from "next/link";
import { getUser } from "@/lib/authentication";

export default async function NavigationBar () {

    const response = await getUser()

    return (
        <nav className="bg-slate-500 border-b-2 rounded-b-lg border-slate-700 fixed w-full h-fit flex flex-row justify-between p-[1rem] text-3xl items-center"> 

            <div className="space-x-10">
                <Link 
                    href={response === 200 ? "/posts" : "/"}
                    scroll={false}
                >
                    My NextJS App
                </Link>
            </div>

            <LoginSection response={response} />

        </nav>
    )
}