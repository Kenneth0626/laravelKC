import { router, useForm } from "@inertiajs/react";
import TodoHeader from "../Components/TodoHeader";
import TodoForm from "../Components/TodoForm";

export default function EditTodo ({ item, page, errors }) {

    const { data, setData, post } = useForm({
        _method: 'patch',
        title: item.title,
        is_checked: item.is_checked,
        page: page,
    })

    function handleSubmit(e){
        e.preventDefault()
        post(`/todo/edit/${item.id}`)
    }

    return (
        <>
            <TodoHeader>
                Edit Todo
            </TodoHeader>

            <TodoForm 
                data={data}
                error={errors.title}
                handleSubmit={handleSubmit}
                returnLabel="Return"
                onInput={e => setData('title', e.target.value)}
                onReturnButton={() => router.get('/todo', {page: page})}
                formLabel="Edit Todo:"
                saveLabel="Save"
            />
        </>
    )
}