import { Link } from "@inertiajs/react";

export default function ({ children, isFallback }) {

    return (
        <div className="flex justify-between min-w-[50rem] p-8 mx-[15rem] mt-14 text-4xl border-4 border-black rounded-lg bg-slate-400"> 
            
            {isFallback === true ? 
                ( <span className="w-[7rem]"/> ) : 
                (
                    <Link 
                        href='/home'
                        className="text-green-700 w-[7rem] text-2xl mt-auto underline"
                    >
                        Home
                    </Link> 
            )}

            <h1>
                {children}
            </h1>

            <span className="w-[7rem]"/>

        </div>
    )
}