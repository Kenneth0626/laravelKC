
import PostCommentItem from "./PostCommentItem";

export default function PostCommentsShow ({ commentsData, guestID, item, setItem, commentPage }) {

    return (
        <>
            {commentsData.length === 0 && (
                <div className="text-center text-4xl italic text-slate-600 mt-[1rem]">
                    no comments
                </div>
            )}

            <div className="mt-[1rem]">
                { commentsData.map(comment => (

                        <PostCommentItem
                            key={comment.id}
                            comment={comment}
                            guestID={guestID}
                            item={item}
                            setItem={setItem}
                            commentPage={commentPage}
                            itemCount={commentsData.length}
                        />

                ))}
            </div>
        </>
    )
}