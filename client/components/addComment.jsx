import { useState, useTransition } from "react"
import { StoreComment } from "@/lib/commentActions"

export default function AddComment ({ postID, doSetMutate }) {

    const [comment, setComment] = useState('')

    const [isPending, startTransition] = useTransition()

    async function handleSubmit (e) {

        e.preventDefault()

        if(comment.length !== 0){

            const res = await StoreComment(postID, comment)

            if(res === 200){
                doSetMutate(true)
            }

        }

        setComment('')

    }

    return (
        <form 
            onSubmit={e => startTransition(() => handleSubmit(e))}
            className="flex flex-row space-x-2"
        >

            <textarea 
                value={comment}
                onChange={e => setComment(e.target.value)}
                placeholder="add comment..."
                className="border-2 border-slate-400 rounded-lg p-2 w-full" 
            />

            <button
                className="border-green-500 bg-green-200 border-2 rounded-lg p-2 whitespace-nowrap h-fit my-auto"
                disabled={isPending}
            >
                add comment
            </button>

        </form>
    )
}