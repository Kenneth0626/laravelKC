import CommentItem from "./commentItem";
import LoadMore from "./loadMore";
import FetchLoading from "./fetchLoading";
import useSWRInfinite from 'swr/infinite';
import { useEffect, useState, useTransition } from "react";
import { getPostComments } from "@/lib/postActions";
import { deleteComment, patchComment} from "@/lib/commentActions";

export default function CommentsList ({ id, guestId, doSetMutate, doMutate }) {

    const [doLoadMore, setDoLoadMore] = useState(true)
    const [selectId, setSelectId] = useState(0)
    const [content, setContent] = useState('')

    const [isPending, startTransition] = useTransition()

    const { data, isLoading, isValidating, mutate, size, setSize } = useSWRInfinite((pageIndex, previousPageData) => {
        if (previousPageData) {
            if(!previousPageData.comments.length){
                return null
            } 
        }
        return `${id}?page=${pageIndex + 1}`
    }, getPostComments, { parallel: true })

    async function handleSubmit(e){

        e.preventDefault()

        if(content.length !== 0){
            const res = await patchComment(id, content, selectId)

            if(res === 200){
                mutate()
            }
        }

        setSelectId(0)
        setContent('')
        
    }   

    async function destroyComment(id){
        
        const res = await deleteComment(id)
        
        if(res === 204){
            mutate()
        }

    }

    useEffect(() => {

        if(doMutate === true){
            doSetMutate(false)
            mutate()
        }

    }, [doMutate])

    useEffect(() => {

        if(doLoadMore && data?.length === (data ? data[data.length - 1].lastPage : 1)){
            setDoLoadMore(false)
        }

    }, [doLoadMore, data])

    if(isLoading){
        return (
            <FetchLoading 
                textStyle="text-2xl text-slate-400"
            />
        )
    }

    return (
        <> 
            { data[0].comments?.length > 0 ? 
                (
                    <>
                        { data.map(item => {
                            return item.comments.map(comment => (
                                <CommentItem 
                                    key={comment.id}
                                    data={comment}
                                    isOwner={comment.owner.id === guestId}
                                    isEditing={selectId === comment.id && isPending === false}
                                    inputValue={content}
                                    onInputChange={setContent}
                                    setCommentId={setSelectId}
                                    onHandleSubmit={e => startTransition(() => handleSubmit(e))}
                                    loadingState={isPending}
                                    destroy={() => startTransition(() => destroyComment(comment.id))}
                                />
                            ))
                        })}

                        <LoadMore 
                            hasMore={data[0].lastPage > 1}
                            isLoading={isValidating}
                            doLoad={doLoadMore}
                            onButtonClick={() => setSize(size + 1)}
                            buttonStyle="text-xl text-blue-600 "
                            loadingStyle="text-xl text-slate-400"
                        /> 

                    </>
                ):
                (
                    <span className="text-center text-2xl italic text-slate-400">
                        no comments
                    </span>
                )   
            }
        </>    
    )
}