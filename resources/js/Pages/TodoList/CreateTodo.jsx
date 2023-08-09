import { router, useForm } from "@inertiajs/react";
import TodoHeader from "../Components/TodoHeader";
import TodoForm from "../Components/TodoForm";

export default function CreateTodo ({ page, user_id, errors }) {

    const { data, setData, post } = useForm({
        user_id: user_id,
        title: '',
        is_checked: 0,
        page: page,
    })

    function handleSubmit(e){
        e.preventDefault()
        post('/todo/create')
    }

    return (
        <>
            <TodoHeader>
                Create Todo
            </TodoHeader>

            <TodoForm 
                data={data}
                error={errors.title}
                handleSubmit={handleSubmit}
                returnLabel="Return"
                onInput={e => setData('title', e.target.value)}
                onReturnButton={() => router.get('/todo', {page: page})}
                formLabel="Enter New Todo:"
                saveLabel="Add"
            />
        </>
    )
}