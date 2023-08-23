
export default function FormInput (
    { inputType = 'text', useTextArea = false, errorStyle = "text-xs", 
      onInputChange, placeholder, label, inputError, value, inputStyle }) {
    return (
        <>
            <label className="mt-4">
                {label}
            </label>

            {inputError && <span className={`text-red-600 ${errorStyle}`}> {inputError} </span>}

            { useTextArea === true ? 
                (
                    <textarea
                        type={inputType}
                        value={value}
                        maxLength="255"
                        placeholder={placeholder}
                        className={`rounded-lg ${inputStyle}`}
                        onChange={onInputChange}
                    />
                ) : 
                (
                    <input
                        type={inputType}
                        value={value}
                        maxLength="255"
                        placeholder={placeholder}
                        className={`rounded-lg ${inputStyle}`}
                        onChange={onInputChange}
                    />
                )
            }
            
        </>
    )
}