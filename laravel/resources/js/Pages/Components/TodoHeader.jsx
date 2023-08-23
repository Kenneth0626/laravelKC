import { Link } from "@inertiajs/react";

export default function ({ children, linkLabel = "Home", linkhref = "/home", linkStyle = "text-green-700 text-2xl",isFallback }) {

    return (
        <div className="flex justify-between min-w-[80rem] max-w-[80rem] p-8 mx-auto mt-14 text-4xl 
            border-4 border-black rounded-lg bg-slate-400"> 
            
            {isFallback === true ? 
                ( <span className="w-[7rem]"/> ) : 
                (
                    <Link 
                        href={linkhref}
                        className={`w-[7rem] mt-auto underline ${linkStyle}`}
                    >
                        {linkLabel}
                    </Link> 
            )}

            {children}

            <span className="w-[7rem]"/>

        </div>
    )
}