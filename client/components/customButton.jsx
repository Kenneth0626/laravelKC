
export default function CustomButton ({ children, addStyles, disabled, tabIndex = 0 }) {
    return (
        <button 
            className={`border-2 rounded-lg ${addStyles}`}
            disabled={disabled}
            tabIndex={tabIndex}
        >
            { children }
        </button>
    )
}