import { router, useForm } from "@inertiajs/react"
import { useEffect, useState } from "react"
import TodoLayout from "../Layout/TodoLayout"
import Pagination from "../Components/Pagination"
import CustomLink from "../Components/CustomLink"
import PostHeader from "../Components/PostHeader"
import PostHeaderData from "../Components/PostHeaderData"
import PostHeaderOptions from "../Components/PostHeaderOptions"
import PostContent from "../Components/PostContent"
import PostComments from "../Components/PostComments"
import PostCommentsAdd from "../Components/PostCommentsAdd"
import PostCommentsShow from "../Components/PostCommentsShow"

export default function ShowPost ({ postData, guest, comments, currentPage }) {

    const [item, setItem] = useState({
        isEditing: false,
        id: 0,
    })

    const { data, setData, post, processing, reset } = useForm({
        user_id: guest.id,
        user_username: guest.username,
        content: '',
    })

    function handleSubmit(e){
        e.preventDefault()
        post(`/post/${postData.id}/comment`, {
            onSuccess: () => reset('content'),
        })
    }

    return (
        <TodoLayout layoutStyle="min-w-[80rem] max-w-[80rem]">

            <PostHeader title={postData.title}>
                
                <PostHeaderData
                    author={postData.username}
                    date={postData.created_at}
                    isEdited={postData.is_edited}
                />
                
                <PostHeaderOptions
                    isPostOwner={postData.user_id === guest.id}
                    onReturnClick={() => router.get(`/post`)}
                    isProcessing={processing}
                >
                    
                    <CustomLink
                        onLinkClick={() => router.get(`/post/${postData.id}/edit`)}
                        buttonStyle="text-green-700"
                        isProcessing={processing}
                    >
                        Edit Post
                    </CustomLink>

                    <CustomLink
                        onLinkClick={() => router.post(`/post/${postData.id}`, {_method: 'delete'}, {preserveScroll: true})}
                        buttonStyle="text-red-600"
                        isProcessing={processing}
                    >
                        Delete Post
                    </CustomLink>

                </PostHeaderOptions>

            </PostHeader>
            
            <PostContent>
                {postData.content}
            </PostContent>

            <PostComments>

                <PostCommentsAdd 
                    isGuestMember={guest.is_member}
                    showAddComment={item.isEditing === false && guest.is_member === true}
                    handleSubmit={handleSubmit}
                    value={data.content}
                    onInputChange={e => setData('content', e.target.value)}
                    isProcessing={processing}
                />

                <h1 className="text-2xl mt-[1rem]">
                    Comments
                </h1>

                <PostCommentsShow
                    commentsData={comments.data}
                    guestID={guest.id}
                    item={item}
                    setItem={setItem}
                    commentPage={currentPage}
                />
                
                <Pagination
                    links={comments.links}
                    length={comments.links.length}
                    currentPage={currentPage}
                />

            </PostComments>
            
        </TodoLayout>
    )
}