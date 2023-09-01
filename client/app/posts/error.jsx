'use client'
 
import { useRouter } from 'next/navigation'
import { useEffect } from 'react'
 
export default function Error({ error, reset }) {

    const router = useRouter()

    useEffect(() => {
        console.error(error)
    }, [error])
    
    return (
        <div className="flex flex-col space-y-[2rem]">

            <h2 className="mx-auto text-7xl italic text-cyan-600">
                Something went wrong!
            </h2>

            <button
                className="text-xl hover:underline hover:text-green-600"
                onClick={() => window.location.reload()}
            >
                Try again
            </button>
            
        </div>
    )
}