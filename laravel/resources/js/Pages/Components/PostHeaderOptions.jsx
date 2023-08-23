import CustomLink from "./CustomLink"

export default function PostHeaderOptions({ isPostOwner, onReturnClick, isProcessing, children }) {
    return (
        <div className="flex space-x-10 mt-auto text-2xl">
            { isPostOwner && (
                <>
                    { children }
                </>
            )}

            <CustomLink
                onLinkClick={onReturnClick}
                buttonStyle="text-blue-700"
                isProcessing={isProcessing}
            >
                Return
            </CustomLink>

        </div>
    )
}