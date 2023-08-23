
export default function PostContent ({ children }) {
    return (
        <>
            <p className="my-7 text-2xl whitespace-normal bg-slate-50 rounded-lg px-2 py-2">
                {children}
            </p>
            
            <hr className="border-t-4 border-black rounded-full" />
        </>
    )
}