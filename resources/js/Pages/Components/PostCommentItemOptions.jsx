import CustomLink from "./CustomLink";

export default function PostCommentItemOptions ({ isEditing, onEdit, onDelete, isProcessing }) {
    return (
        <>
            { isEditing === false && (
                <>
                    <CustomLink
                        buttonStyle="italic text-green-700"
                        isProcessing={isProcessing}
                        onLinkClick={onEdit}
                    >
                        edit
                    </CustomLink>
                    
                    <CustomLink
                        buttonStyle="italic text-red-600"
                        isProcessing={isProcessing}
                        onLinkClick={onDelete}
                    >
                        delete
                    </CustomLink>
                </> 
            )}
        </>
    )
}