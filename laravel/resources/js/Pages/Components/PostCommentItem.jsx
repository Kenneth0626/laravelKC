import { router, useForm } from "@inertiajs/react"
import PostCommentContent from "./PostCommentContent"
import PostCommentEditItemOptions from "./PostCommentEditItemOptions"
import PostCommentItemOptions from "./PostCommentItemOptions"

export default function PostCommentItem ({ comment, guestID, isProcessing, item, setItem, commentPage = 1, itemCount }) {

    const { data, setData, post, processing, reset } = useForm({
        _method: 'patch',
        id: comment.id,
        content: comment.content,
    })

    function handleSubmit(e){
        e.preventDefault()
        post(`/post/${comment.post_id}/comment`, {
            onSuccess: () => reset('content'),
        })
    }

    function onCommentEdit(state, user_id, comment_id) {
        if(user_id === guestID){
            setItem({...item, isEditing: state, id: comment_id})
            if(state === false){
                reset('content')
            }
        }
    }

    function handleSubmit(e){
        e.preventDefault()
        post(`/post/${comment.post_id}/comment`, {
            preserveScroll: true,
            onSuccess: () => setItem({...item, isEditing: false, id: 0})
        })
    }

    function highlightMyComment(item_id, guest_id){
        return (item_id === guest_id) ? "bg-green-200" : "bg-slate-50"
    }

    return (
        <div className={`mb-2 border-2 border-white rounded-lg space-y-1 px-2 py-2 ${highlightMyComment(comment.user_id, guestID)}`}>

            <div className="flex space-x-2">

                <h2 className="my-auto text-ellipsis overflow-hidden">
                    {comment.user_username}
                </h2>

                <span className="italic text-sm my-auto">
                    commented on {comment.created_at}
                    {comment.updated_at != comment.created_at && " (edited)"}
                </span>

                { comment.user_id === guestID && (
                    <div className="flex space-x-2 my-auto text-base">

                        <PostCommentEditItemOptions 
                            isEditing={item.isEditing}
                            isCommentOwner={comment.id === item.id}
                            onSave={handleSubmit}
                            onCancel={() => onCommentEdit(false, comment.user_id, 0)}
                            isProcessing={processing}
                        />

                        <PostCommentItemOptions 
                            isEditing={item.isEditing}
                            onEdit={() => onCommentEdit(true, comment.user_id, comment.id)}
                            onDelete={() => router.post(`/post/${comment.post_id}/comment`,
                                {
                                    _method: 'delete',
                                    page: commentPage,
                                    itemCount: itemCount,
                                    comment_id: data.id
                                },
                                { preserveScroll: true }
                            )}
                            isProcessing={processing || isProcessing}
                        />
                        
                    </div>
                )}

            </div>

            <PostCommentContent
                isEditing={item.isEditing}
                isCommentOwner={comment.id === item.id}
                content={comment.content}
                value={data.content}
                onInputChange={e => setData('content', e.target.value)}
            /> 

        </div>
    )
}