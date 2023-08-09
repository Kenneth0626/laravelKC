
export default function CustomLink ({ onLinkClick, buttonStyle, isProcessing, children }) {
    return (
        <button
            type="button"
            onClick={onLinkClick}
            className={`underline underline-offset-2 mt-auto ${buttonStyle}`}
            disabled={isProcessing}
        >
            {children}
        </button>
    )
}