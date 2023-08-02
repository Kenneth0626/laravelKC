
import { router } from "@inertiajs/react";
import { useForm } from 'laravel-precognition-react-inertia';
import TodoHeader from "../Components/TodoHeader";
import TodoForm from "../Components/TodoForm";

export default function EditTodo ({ item }) {

    const form = useForm('post', `/edit/${item.id}`, {
        _method: 'patch',
        title: item.title,
        is_checked: item.is_checked,
    })

    const handleSubmit = (e) => {
        e.preventDefault()
        form.submit()
    }

    return (
        <>
            <TodoHeader>
                Edit Todo
            </TodoHeader>

            <TodoForm 
                form={form}
                handleSubmit={handleSubmit}
                returnLabel="Return"
                onReturnButton={() => window.history.back()}
                formLabel="Edit Todo:"
                saveLabel="Save"
            />
        </>
    )
}