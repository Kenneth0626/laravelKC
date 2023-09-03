"use client"

import FetchLoading from "@/components/fetchLoading";
import PostItem from "@/components/postItem";
import LoadMore from "@/components/loadMore";
import useSWRInfinite from 'swr/infinite'
import { useEffect, useState } from "react";
import Link from "next/link";
import { getPosts } from "@/lib/postActions";

export default function PostsList () {
    
    const { data, isLoading, isValidating, size, setSize } = useSWRInfinite((pageIndex, previousPageData) => {

        if (previousPageData) {
            if(!previousPageData.posts.length){
                return null
            } 
        }

        return `posts?page=${pageIndex + 1}`

    }, getPosts, { parallel: true, revalidateAll: true })
    
    const [doLoadMore, setDoLoadMore] = useState(true)
    const [load, setLoad] = useState(false)

    useEffect(() => {

        if(doLoadMore && data?.length === (data ? data[data.length - 1].lastPage : 1)){
            setDoLoadMore(false)
        }

    }, [doLoadMore, data])

    useEffect(() => {

        if(!isValidating && load){
            setLoad(false)
        }

    }, [load, isValidating])

    function onLoadMore(){

        setSize(size + 1)
        setLoad(true)
        
    }
 
    if (isLoading || ( isValidating && !load )){
        return (
            <FetchLoading />
        )
    }

    return (
        <div className="flex flex-col space-y-5">

            <h1 className="text-6xl"> 
                Posts 
            </h1>

            <div className="flex flex-col space-y-3">

                { ( data ? data[0].guest_id : null ) !== null && (
                    <Link
                        href="/posts/create"
                        className="text-xl border-2 border-black bg-green-300 rounded-lg p-2 w-fit"
                    >
                        Add Posts
                    </Link>
                )}

                { ( data ? data[0].posts.length === 0 : false ) && <span className="flex mx-auto text-6xl italic text-cyan-600"> no posts... </span>}
                { data?.map(item => {
                    return item?.posts?.map(post => (
                        <PostItem 
                            key={post.id}
                            guestID={data ? data[0].guest_id : null}
                            postData={post}
                        />
                    )) }
                )}

                <LoadMore
                    hasMore={(data ? data[0].lastPage : 1) > 1}
                    isLoading={isValidating}
                    doLoad={doLoadMore}
                    onButtonClick={() => onLoadMore()}
                    buttonStyle="text-2xl"
                    loadingStyle="text-2xl text-cyan-700"
                />

            </div>

        </div>
    )
}