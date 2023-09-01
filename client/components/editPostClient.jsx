"use client"

import CustomButton from "@/components/customButton";
import LabelInput from "@/components/labelInput";
import patchPost from "@/lib/post/patchPost";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState, useTransition } from "react";

export default function EditPostClient ({ postId, postTitle, postContent }) {

    const [title, setTitle] = useState(postTitle)
    const [content, setContent] = useState(postContent)
    const [errors, setErrors] = useState('')

    const [isPending, startTransition] = useTransition()

    const router = useRouter()
    
    async function handleSubmit(e){

        e.preventDefault()

        const res = await patchPost(postId, title, content)
        
        if(res?.errors){
            setErrors(res.errors)
        }

        if(res === 200){
            router.push(`/posts/${postId}`, { scroll: false })
        }

    }

    return (
        <>
            <div className="flex flex-row justify-between">
                
                <h1 className="text-5xl">
                    Edit Post
                </h1>

                <Link
                    href={`/posts/${postId}`}
                    className="mt-auto text-xl text-blue-500 underline"
                >
                    Return
                </Link>

            </div>
            
            <hr className="border-black border-2 rounded-full my-[1rem]" />

            <form 
                onSubmit={e => startTransition(() => handleSubmit(e))}
                className="flex flex-col space-y-5"
            >

                <LabelInput
                    label="Title"
                    type="text"
                    value={title}
                    onChange={e => setTitle(e.target.value)}
                    placeholder="title..."
                    labelStyle="text-3xl"
                    inputStyle="border-slate-300 text-xl"
                    errors={errors?.title}
                />

                <LabelInput 
                    label="Content"
                    useTextArea={true}
                    type="text"
                    value={content}
                    onChange={e => setContent(e.target.value)}
                    placeholder="content..."
                    labelStyle="text-3xl"
                    inputStyle="border-slate-300 text-xl"
                    errors={errors?.content}
                />

                { isPending === true ? 
                    (
                        <span className="text-2xl text-center italic text-slate-400">
                            updating...
                        </span>
                    ):
                    (
                        <CustomButton addStyles="w-fit p-2 mx-auto border-green-500 bg-green-200 text-2xl">
                            Save Change
                        </CustomButton>
                    ) 
                }

            </form>

        </>
    )
}