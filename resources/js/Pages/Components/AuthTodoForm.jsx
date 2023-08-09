
export default function AuthTodoForm ({ formStyle = "flex-col", onSubmitButton, children }) {
    return (
        <form
            onSubmit={onSubmitButton}
            className={`flex space-y-3 ${formStyle}`}
        >
            {children}
        </form>
    )
}