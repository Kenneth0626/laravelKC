
export default function CommentItem ({ data, isOwner, isEditing, inputValue, onInputChange, setCommentId, onHandleSubmit, loadingState, destroy }) {

    function editComment(commentId, commentContent){
        setCommentId(commentId)
        onInputChange(commentContent)
    }

    function isAuthor(){
        return isOwner ? "border-blue-700 bg-blue-100" : "border-slate-400 bg-slate-200"
    }

    return (
        <div className={`flex flex-col space-y-2 border-2 rounded-lg p-3 ${isAuthor()}`}>
            
            <div className="flex flex-row space-x-2 items-baseline">

                <span className="text-base font-bold">
                    { data?.owner?.name }
                </span>

                <span className="text-sm italic"> 
                    commented at { data?.attributes?.created_at }
                </span>

                { data?.attributes?.created_at !== data?.attributes?.updated_at && (
                    <span className="text-sm italic">
                        {"(edited)"}
                    </span>
                )}

                <div className="text-xs italic flex flex-row space-x-2">
                    { isOwner === true && (
                        <>
                            { isEditing === true ? 
                                (
                                    <>  

                                        <button
                                            onClick={onHandleSubmit}
                                            className="text-green-500 underline"
                                        >
                                            save
                                        </button>

                                        <button
                                            onClick={() => editComment(0, '')}
                                            className="text-red-500 underline"
                                        >
                                            cancel
                                        </button>

                                    </>
                                ):
                                (
                                    <>
                                        { loadingState === true ? 
                                            (
                                                <span>
                                                    loading...
                                                </span>
                                            ):
                                            (
                                                <>

                                                    <button
                                                        onClick={() => editComment(data?.id, data?.attributes?.content)}
                                                        className="text-green-500 underline"
                                                    >
                                                        edit
                                                    </button>

                                                    <button
                                                        onClick={destroy}
                                                        className="text-red-500 underline"
                                                    >
                                                        delete
                                                    </button>

                                                </>
                                            ) 
                                        }
                                    </>
                                )
                            }  
                        </>
                    )}
                </div>

            </div>
            
            { isEditing === true ? 
                (   
                    <textarea 
                        value={inputValue}
                        onChange={e => onInputChange(e.target.value)}
                        maxLength="255"
                        className="text-xl p-2 w-full"
                    />
                ):
                (
                    <p className="text-xl">
                        { data.attributes.content }
                    </p>
                )
            }

        </div>
    )
}