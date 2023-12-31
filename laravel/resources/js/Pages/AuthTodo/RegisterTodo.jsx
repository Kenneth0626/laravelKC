import { useForm, usePage, router } from '@inertiajs/react'
import AuthTodoHeader from '../Components/AuthTodoHeader'
import AuthTodoForm from '../Components/AuthTodoForm'
import FormInput from '../Components/FormInput'
import AuthTodoFormAction from '../Components/AuthTodoFormAction'
import CustomLink from '../Components/CustomLink'
import CustomButton from "../Components/CustomButton"
import TodoLayout from '../Layout/TodoLayout'

export default function RegisterTodo () {

    const { errors } = usePage().props

    const { data, setData, post, processing, reset } = useForm({
        username: '',
        email: '',
        password: '',
        password_confirmation: '',
    })

    function handleSubmit(e){
        e.preventDefault()
        post('/register', {
            onError: () => reset('password', 'password_confirmation')
        })
    }

    return (
        <TodoLayout layoutStyle="min-w-[30rem] max-w-[30rem]">

            <AuthTodoHeader>

                <h1 className="text-2xl">
                    Todo List Registration
                </h1>
                
            </AuthTodoHeader>
                
            <AuthTodoForm onSubmitButton={handleSubmit}>
                
                <FormInput 
                    label='Username'
                    inputError={errors.username}
                    value={data.username}
                    onInputChange={e => setData('username', e.target.value)}
                />
                
                <FormInput 
                    label='Email'
                    inputError={errors.email}
                    inputType='email'
                    value={data.email}
                    onInputChange={e => setData('email', e.target.value)}
                />
                
                <FormInput 
                    label='Password'
                    inputError={errors.password}
                    inputType='password'
                    value={data.password}
                    onInputChange={e => setData('password', e.target.value)}
                />
                    
                <FormInput 
                    label='Confirm Password'
                    inputType='password'
                    value={data.password_confirmation}
                    onInputChange={e => setData('password_confirmation', e.target.value)}
                />
                    
                <AuthTodoFormAction>
                    
                    <CustomLink
                        onLinkClick={() => router.get('/login')}
                        buttonStyle='text-blue-700 text-sm mt-auto'
                        isProcessing={processing}
                    >
                        Already Registered?
                    </CustomLink>
                    
                    <CustomButton
                        buttonStyle='border-green-500 bg-green-200'
                        isProcessing={processing}
                    >
                        Register
                    </CustomButton>
                    
                </AuthTodoFormAction>

            </AuthTodoForm>

        </TodoLayout>
    )
}