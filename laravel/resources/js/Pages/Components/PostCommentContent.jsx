
export default function PostCommentContent ({ isEditing, isCommentOwner, content, value, onInputChange }) {
    return (
        <>
            {(isEditing === true && isCommentOwner === true) ? 
                (
                    <form className="">

                        <textarea
                            className="flex text-xl rounded-lg w-[75rem] mx-auto"
                            maxLength="255"
                            value={value}
                            onChange={onInputChange}
                        />

                    </form>
                ) :
                (
                    <p className="whitespace-normal break-words">
                        {content}
                    </p>
                )
            }
        </>
    )
}