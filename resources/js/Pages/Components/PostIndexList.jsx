import { router } from "@inertiajs/react"
import CustomButton from "./CustomButton"

export default function PostIndexList ({ children, isGuestMember, postData, currentPage, guestID }) {

    function highlightMyPost(post_id, guest_id){
        return post_id === guest_id ? "border-blue-600 bg-blue-300" : "border-black bg-slate-300"
    }

    return (
        <div className="flex flex-col space-y-3 mt-10 min-w-[80rem] max-w-[80rem] mx-auto">
            
            { isGuestMember === true ? 
                (
                    <CustomButton
                        onButtonClick={() => router.get('/post/create', {page: currentPage})}
                        buttonStyle = "border-green-500 bg-green-200 font-bold text-2xl w-fit"
                    >
                        Add Post
                    </CustomButton>
                ) : 
                (
                    <CustomButton
                        onButtonClick={() => router.get('/login')}
                        buttonStyle = "border-black bg-slate-50 font-bold text-2xl w-fit"
                    >
                        Login to Post
                    </CustomButton>
                )
            }

            <div className="flex flex-col space-y-3 space">

                { postData.length === 0 && (
                    <span className="text-7xl italic text-center text-cyan-600 p-2 mt-[9rem]"> 
                        There are no Posts 
                    </span>
                )}

                { postData.map(data => (
                    <div 
                        className={`flex flex-col space-y-2 border-4 rounded-lg p-8 text-4xl 
                            hover:border-green-600 hover:bg-green-200 ${highlightMyPost(data.user_id, guestID)}`}
                        onClick={() => router.get(`/post/${data.id}`, {postPage: currentPage})}
                        key={data.id}  
                    >   
                        
                        <h1 className="text-ellipsis overflow-hidden">
                            {data.title}
                        </h1>
                            
                        <div className="italic text-xl">
                            
                            <h2>
                                by: {data.user_username}
                            </h2>

                            <h2>
                                
                                posted on {data.created_at}
                                    
                                { data.created_at != data.updated_at && <span> (edited) </span>}
                                
                            </h2>
                                
                        </div>
                    </div>
                ))}

                { children }

            </div>
            
        </div>
    )
}