
import Link from "next/link"

export default function PostItem ({ guestID, postData }){

    function isAuthor(){
        return postData.author.id === guestID ? "border-blue-700 bg-blue-200" : "border-black bg-slate-200"
    }

    return (
        <Link
            href={`/posts/${ postData.id }`}
            className={`border-2 hover:bg-green-300 rounded-lg p-5 ${isAuthor()}`}
        >

            <div className="whitespace-nowrap">

                <h1 className="text-5xl text-ellipsis overflow-hidden leading-tight"> 
                    { postData.attributes.title } 
                </h1>

                <h2 className="text-2xl leading-snug"> 
                    { postData.author.name } 
                </h2>

                <div className="flex space-x-2">

                    <span className="text-xl italic"> 
                        { postData.attributes.created_at } 
                    </span>

                    { postData.attributes.created_at !== postData.attributes.updated_at && (
                        <span className="text-xl italic">
                            {"(edited)"}
                        </span>
                    )}

                </div>

            </div>
            
        </Link>
    )
}