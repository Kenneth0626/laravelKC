import { usePage, useForm, router } from '@inertiajs/react'
import AuthTodoHeader from '../Components/AuthTodoHeader'
import TodoLayout from '../Layout/TodoLayout'
import AuthTodoForm from '../Components/AuthTodoForm'
import FormInput from '../Components/FormInput'
import AuthTodoFormAction from '../Components/AuthTodoFormAction'
import CustomLink from '../Components/CustomLink'
import CustomButton from "../Components/CustomButton"

export default function RegisterTodo () {

    const { errors } = usePage().props

    const { data, setData, post, processing, reset } = useForm ({
        email: '',
        password: '',
    })

    function handleSubmit(e){
        e.preventDefault()
        post('/login', {
            onError: () => reset('password')
        })
    }

    return (
        <TodoLayout layoutStyle="min-w-[30rem] max-w-[30rem]">

            <AuthTodoHeader>

                <h1 className="text-2xl">
                    Todo List Login
                </h1>

                <CustomLink
                    onLinkClick={() => router.get('/post')}
                    linkType="button"
                    buttonStyle="text-blue-700"
                    isProcessing={processing}
                >
                    View Posts
                </CustomLink>
                
            </AuthTodoHeader>

            <AuthTodoForm onSubmitButton={handleSubmit}>
                
                <FormInput 
                    label="Email"
                    inputType="email"
                    value={data.email}
                    onInputChange={e => setData('email', e.target.value)}
                />

                <FormInput 
                    label="Password"
                    inputError={errors.password}
                    inputType="password"
                    value={data.password}
                    onInputChange={e => setData('password', e.target.value)}
                />

                <AuthTodoFormAction>

                    <CustomLink
                        onLinkClick={() => router.get('/register')}
                        buttonStyle='text-blue-700 text-sm mt-auto'
                        isProcessing={processing}
                    >
                        Not Registered Yet?
                    </CustomLink>

                    <CustomButton
                        buttonStyle='border-green-500 bg-green-200'
                        isProcessing={processing}
                    >
                        Login
                    </CustomButton>

                </AuthTodoFormAction>

            </AuthTodoForm>

        </TodoLayout>
    )
}