
export default function PostHeader ({ title, children }){
    return(
        <>
            <h1 className="text-5xl whitespace-normal mb-2">
                {title} 
            </h1>

            <div className="flex justify-between mb-[1rem]">
                {children}
            </div>
            
            <hr className="border-t-4 border-black rounded-full" />
        </>
    )
}