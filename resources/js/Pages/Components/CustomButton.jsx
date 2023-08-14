
export default function CustomButton ({ inputType, buttonStyle, onButtonClick, isProcessing, children }) {
    
    return (
        <button
            type={inputType}
            className={`min-w-fit border-4 px-6 py-1 rounded-lg ${buttonStyle}`}
            onClick={onButtonClick}
            disabled={isProcessing}  
        >
            {children}
        </button>
    )
}