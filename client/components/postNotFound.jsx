import Link from "next/link";


export default function PostNotFound () {
    return (
        <>
        
            <div className="flex justify-between">

                <h1 className="text-6xl">
                    Post Not Found
                </h1> 

                <Link
                    href="/posts"
                    scroll={false}
                    className="text-blue-500 mt-auto text-xl hover:underline"
                >
                    Return
                </Link>
                
            </div>

            <hr className="border-black border-2 rounded-full my-[1rem]" />

        </>
    )
}