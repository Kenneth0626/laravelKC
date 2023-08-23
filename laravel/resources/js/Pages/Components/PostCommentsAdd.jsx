import { Link } from "@inertiajs/react";
import CustomButton from "./CustomButton";

export default function PostCommentsAdd ({ isGuestMember, showAddComment, handleSubmit, value, onInputChange, isProcessing }) {
    return (
        <>
            { isGuestMember === false && (
                <div className="text-3xl text-center">

                    <Link
                        className="underline text-blue-700"
                        href='/login'
                    >
                        Login
                    </Link>

                    {" "} to Comment

                </div>
            )}

            { showAddComment === true && (
                <form 
                    className="mb-2"
                    onSubmit={handleSubmit}
                >

                    <div className="flex space-x-3">

                        <textarea
                            className="w-full rounded-lg text-xl"
                            placeholder="comment..."
                            value={value}
                            maxLength="255"
                            onChange={onInputChange}
                        />

                        <CustomButton
                            buttonStyle="border-green-500 bg-green-200 max-h-[3rem] my-auto"
                            isProcessing={isProcessing}
                        >
                            add comment
                        </CustomButton>

                    </div>

                </form>
            )}
        </>
    )
}