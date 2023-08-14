import TodoHeader from "../Components/TodoHeader"
import Pagination from "../Components/Pagination"
import PostIndexList from "../Components/PostIndexList"

export default function IndexPost ({ postData, currentPage, guest }) {
    return (
        <>  
            {guest.is_member === true ? 
                (
                    <TodoHeader>

                        <h1 className="text-6xl">
                            Todo Posts
                        </h1>
                        
                    </TodoHeader>
                ) : 
                (
                    <TodoHeader
                        linkLabel="Login"
                        linkhref="/login"
                        linkStyle="text-blue-700 text-2xl"
                    >

                        <h1 className="text-6xl">
                            Todo Posts
                        </h1>

                    </TodoHeader>
                )
            }

            <PostIndexList
                isGuestMember={guest.is_member}
                postData={postData.data}
                currentPage={currentPage}
                guestID={guest.id}
            >

                <Pagination
                    links={postData.links}
                    length={postData.links.length}
                    currentPage={currentPage}
                />

            </PostIndexList>
        </>
    )
}