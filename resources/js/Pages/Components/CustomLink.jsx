
export default function CustomLink ({ onLinkClick, linkType = "button", buttonStyle, isProcessing, children }) {
    return (
        <button
            type={linkType}
            onClick={onLinkClick}
            className={`underline underline-offset-2 mt-auto ${buttonStyle}`}
            disabled={isProcessing}
        >
            {children}
        </button>
    )
}