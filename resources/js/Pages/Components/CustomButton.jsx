
export default function CustomButton ({ buttonStyle, onButtonClick, children}) {
    
    return (
        <button 
            className={`min-w-fit border-4 px-6 py-2 rounded-lg ${buttonStyle}`}
            onClick={onButtonClick}    
        >
            {children}
        </button>
    )
}