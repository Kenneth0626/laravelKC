import { useForm, usePage, router } from '@inertiajs/react'
import TodoLayout from '../Layout/TodoLayout'
import AuthTodoHeader from '../Components/AuthTodoHeader'
import CustomLink from '../Components/CustomLink'
import AuthTodoForm from '../Components/AuthTodoForm'
import AuthTodoFormAction from '../Components/AuthTodoFormAction'
import CustomButton from "../Components/CustomButton"

export default function VerifyEmail () {

    const { flash } = usePage().props

    const { post, processing } = useForm({});

    function handleSubmit (e) {
        e.preventDefault();
        post('/email/verification-notification');
    };

    return (
        <TodoLayout layoutStyle="min-w-[35rem] max-w-[35rem]">

            <AuthTodoHeader>

                <h1 className='text-4xl'>
                    Verify Email
                </h1>

                <CustomLink
                    onLinkClick={() => router.post('/logout')}
                    isProcessing={processing}
                    buttonStyle='text-red-600'
                >
                    Logout
                </CustomLink>

            </AuthTodoHeader>

            <div className="mt-[1rem] whitespace-normal">

                Before getting started, could you verify your email address by clicking on the link we just emailed to you? 
                <br/><br/>
                If you haven't receive the email yet, you can click on <span className="font-bold"> {' '}Resend Verification Email{' '} </span> below.
                <br/><br/>
                You can close this window after you have verified your email.

            </div>

            <AuthTodoForm 
                formStyle="mt-[1rem]"
                onSubmitButton={handleSubmit}
            >

                <AuthTodoFormAction>
                    
                    <CustomButton
                        buttonStyle="border-green-500 bg-green-200"
                        isProcessing={processing}
                    >
                        Resend Verification Email
                    </CustomButton>

                    { flash.message && <span className='text-green-300 text-sm ml-2 m-auto'> {flash.message} </span>}

                </AuthTodoFormAction>

            </AuthTodoForm>
            
        </TodoLayout>
    )
}
