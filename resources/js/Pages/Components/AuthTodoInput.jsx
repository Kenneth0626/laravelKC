
export default function AuthTodoInput ({ label, inputError, inputType = 'text', value, inputStyle, onInputChange }) {
    return (
        <>
            <label className="mt-4">
                {label}
            </label>
            {inputError && <span className="text-red-600 text-xs"> {inputError} </span>}
            <input
                type={inputType}
                value={value}
                className={`rounded-lg ${inputStyle}`}
                onChange={onInputChange}
            />
        </>
    )
}