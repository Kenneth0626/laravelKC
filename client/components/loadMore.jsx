"use client"

import { useState } from "react"

export default function LoadMore ({ hasMore, isLoading, doLoad, onButtonClick, buttonStyle, loadingStyle }) {

    const [loading, setLoading] = useState(false)

    function handleLoading(){
        onButtonClick()
        setLoading(true)
    }

    if(loading === true && isLoading === false){
        setLoading(false)
    }

    return (
        <>  
            { hasMore === true && (
                <>
                    { loading === true ? 
                        (
                            <h1 className={`${loadingStyle} italic text-center`}>
                                loading...
                            </h1>
                        ):
                        (
                            doLoad === true && (
                                <button 
                                    onClick={() => handleLoading()}
                                    className={`italic hover:underline ${buttonStyle}`}
                                >
                                    Load More...
                                </button>
                            )
                        )
                    }
                </>
            )}
        </>
    )
}