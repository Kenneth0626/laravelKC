import AuthTodoForm from '../Components/AuthTodoForm'
import AuthTodoFormAction from '../Components/AuthTodoFormAction'
import AuthTodoHeader from '../Components/AuthTodoHeader'
import AuthTodoInput from '../Components/AuthTodoInput'
import CustomButton from '../Components/CustomButton'
import AuthTodoLayout from '../Layout/AuthTodoLayout'
import { useForm, Link } from '@inertiajs/react'

export default function ProfileTodo ({ username, errors }) {

    const { data, setData, post } = useForm({
        _method: 'patch',
        username: username
    })

    function handleSubmit(e){
        e.preventDefault()
        post('/profile')
    }

    return (
        <AuthTodoLayout layoutStyle="min-w-[80rem] max-w-[80rem]">
            
            <AuthTodoHeader>

                <h1 className="text-4xl">
                    Edit Profile
                </h1>

                <div className="flex space-x-20 mt-auto">
            
                    <Link 
                        href='/todo'
                        className="text-blue-800"    
                    >
                        My Todos
                    </Link>
            
                    <Link 
                        href='/home'
                        className="text-green-700"    
                    >
                        Home
                    </Link>
                    
                    <Link
                        href='/logout'
                        method='post'
                        as='button' 
                        className="text-red-600 underline"
                    >
                        Logout
                    </Link>
                    
                </div>

            </AuthTodoHeader>

            <AuthTodoForm 
                formStyle="flex-col justify-start"
                onSubmitButton={handleSubmit}
            >

                <AuthTodoInput 
                    label="Name"
                    inputError={errors.username}
                    value={data.username}
                    inputStyle="w-[20rem]"
                    onInputChange={e => setData('username', e.target.value)}
                />

                <AuthTodoFormAction formActionStyle="justify-start">

                    <CustomButton
                        buttonStyle="w-[20rem] border-green-500 bg-green-200 mt-"
                    >
                        Save
                    </CustomButton>

                </AuthTodoFormAction>
                
            </AuthTodoForm>

        </AuthTodoLayout>
    )
}