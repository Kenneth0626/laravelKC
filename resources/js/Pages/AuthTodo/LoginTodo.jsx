import { usePage, useForm, router } from '@inertiajs/react'
import AuthTodoHeader from '../Components/AuthTodoHeader'
import AuthTodoLayout from '../Layout/AuthTodoLayout'
import AuthTodoForm from '../Components/AuthTodoForm'
import AuthTodoInput from '../Components/AuthTodoInput'
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
        <AuthTodoLayout layoutStyle="min-w-[30rem] max-w-[30rem]">

            <AuthTodoHeader>

                <h1 className="text-2xl">
                    Todo List Login
                </h1>
                
            </AuthTodoHeader>

            <AuthTodoForm onSubmitButton={handleSubmit}>
                
                <AuthTodoInput 
                    label="Email"
                    inputType="email"
                    value={data.email}
                    onInputChange={e => setData('email', e.target.value)}
                />

                <AuthTodoInput 
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

        </AuthTodoLayout>
    )
}