
import { router } from "@inertiajs/react";
import { useForm } from 'laravel-precognition-react-inertia';
import TodoHeader from "../Components/TodoHeader";
import TodoForm from "../Components/TodoForm";

export default function CreateTodo () {

    const form = useForm('post', '/create', {
        title: '',
        is_checked: 0,
    })  

    function handleSubmit (e) {
        e.preventDefault()
        form.submit()
    }

    return (
        <>
            <TodoHeader>
                Create Todo
            </TodoHeader>

            <TodoForm 
                form={form}
                handleSubmit={handleSubmit}
                returnLabel="Return"
                onReturnButton={() => window.history.back()}
                formLabel="Enter New Todo:"
                saveLabel="Add"
            />
        </>
    )
}