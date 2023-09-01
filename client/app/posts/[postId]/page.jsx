"use client"

import AddComment from "@/components/addComment";
import CommentsList from "@/components/commentsList";
import FetchLoading from "@/components/fetchLoading";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState, useTransition } from "react";
import useSWR from 'swr';
import { deletePost, getPostData } from "@/lib/postActions";
 
 export default function ShowPost ({ params }) {
    
    const { data, isLoading, isValidating } = useSWR(`posts/${params.postId}`, getPostData)

    const [mutate, setMutate] = useState(false) 

    const [isPending, startTransition] = useTransition()

    const router = useRouter()

    if (isLoading || isPending || isValidating){
        return (
            <FetchLoading textStyle="text-4xl text-slate-400"/>
        )
    }

    async function destroyPost(id){

        const res = await deletePost(id)

        if(res === 204){
            router.push('/posts', { scroll: false })
        }

    }

    return (
        <>

            <div className="flex flex-col space-y-3">

                <h1 className="text-6xl">
                    { data?.post?.attributes?.title }
                </h1>

                <div className="flex flex-row justify-between">
                    
                    <div className="flex flex-col">
                        
                        <div className="text-3xl">

                            <span className="italic">
                                by {" "}
                            </span>

                            <span className="font-semibold leading-tight">
                                { data?.post?.author?.name }
                            </span> 

                        </div>

                        <div className="flex space-x-2">

                            <span className="text-xl italic">
                                posted at { data?.post?.attributes?.created_at }
                            </span>

                            { data?.post.attributes?.created_at !== data?.post?.attributes?.updated_at && (
                                <span className="text-xl italic">
                                    {"(edited)"}
                                </span>
                            )}

                        </div>

                    </div>

                    <div className="mt-auto flex gap-[6rem] text-xl">
                        
                        { (data ? data.guest_id === data.post.author.id : false) && (
                            <>

                                <Link
                                    href={`/posts/${params.postId}/edit`}
                                    className="text-green-500 underline"
                                >
                                    Edit Post
                                </Link>

                                <button
                                    onClick={() => startTransition(() => destroyPost(params.postId))}
                                    className="text-red-500 underline"
                                >
                                    Delete Post
                                </button>
                                
                            </>
                        )}

                        <Link
                            href="/posts"
                            scroll={false}
                            className="text-blue-500"
                        >
                            Return
                        </Link>

                    </div>

                </div>

            </div>
           
            <hr className="border-black border-2 rounded-full my-[1rem]" />

            <p className="text-2xl whitespace-normal px-5 break-words">
                { data?.post?.attributes?.content }
            </p>

            <hr className="border-black border-2 rounded-full my-[1rem]" />

            <div className="flex flex-col space-y-3">
                
                { (data ? data.guest_id !== null : false) ? 
                    (
                        <AddComment 
                            postID={params.postId}
                            doSetMutate={setMutate}
                        />
                    ):
                    (
                        <div className="text-center text-3xl text-slate-400 italic">
                            <span>Login to Comment</span>
                        </div>
                        
                    )
                }
                
                <div className="flex flex-col space-y-2">

                    <h1 className="text-xl">
                        Comments
                    </h1>

                    <CommentsList 
                        id={params.postId}
                        guestId={data?.guest_id}
                        doSetMutate={setMutate}
                        doMutate={mutate}
                    />

                </div>

            </div>
        
        </>
    )
 }