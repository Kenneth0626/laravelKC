import CustomLink from "./CustomLink";

export default function PostCommentEditItemOptions ({ isEditing, isCommentOwner, onSave, onCancel, isProcessing }) {

    return (
        <>
            {( isEditing === true && isCommentOwner === true) && (
                <>
                    <CustomLink
                        buttonStyle="italic text-green-700"
                        onLinkClick={onSave}
                        isProcessing={isProcessing}
                    >
                        save
                    </CustomLink>

                    <CustomLink
                        buttonStyle="italic text-red-600"
                        linkType="button"
                        onLinkClick={onCancel}
                        isProcessing={isProcessing}
                    >
                        cancel
                    </CustomLink>
                </>
            )}
        </>
    )
}