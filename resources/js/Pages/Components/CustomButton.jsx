
export default function CustomButton ({ buttonStyle, onButtonClick, isProcessing, children}) {
    
    return (
        <button 
            className={`min-w-fit border-4 px-6 py-1 rounded-lg ${buttonStyle}`}
            onClick={onButtonClick}
            disabled={isProcessing}  
        >
            {children}
        </button>
    )
}