import Echo from 'laravel-echo'
import Pusher from 'pusher-js'
import { router, useForm } from '@inertiajs/react'
import { useEffect, useRef, useState } from 'react'
import CustomLink from '../Components/CustomLink'
import ChatHeader from '../Components/ChatHeader'
import ChatBox from '../Components/ChatBox'
import ChatFooter from '../Components/ChatFooter'
import ChatLayout from '../Layout/ChatLayout'

window.Pusher = Pusher;
 
window.Echo = new Echo({
    broadcaster: 'pusher',
    key: import.meta.env.VITE_PUSHER_APP_KEY,
    cluster: import.meta.env.VITE_PUSHER_APP_CLUSTER,
    forceTLS: true
});

export default function GeneralChat ({ guest, errors }) {

    const [messages, setMessages] = useState([])
    const [sentMessages, setSentMessages] = useState([])
    const [userTyping, setUserTyping] = useState([])
    const [sendCounter, setSendCounter] = useState(0)
    const [userCount, setUserCount] = useState(0)
    const [doScroll, setDoScroll] = useState(false)

    const { data, setData, post, reset } = useForm({
        user_id: guest.id,
        user_username: guest.username,
        content: '',
        send_index: null,
    })

    const container = useRef(null)
    const latestMessage = useRef(null)

    useEffect(() => {
        window.Echo.join('general-chat')            
            .joining((user) => {
                const joinMessage ={
                    has_joined: true,
                    username: user.username
                }
                setMessages((prevMessages) => [...prevMessages, joinMessage])
                setUserCount(prevCount => prevCount + 1)
                setDoScroll(isScrollBottom())
            })
            .here((users) => {
                const joinMessage ={
                    has_joined: true,
                    username: guest.username
                }
                setMessages((prevMessages) => [...prevMessages, joinMessage])
                setUserCount(prevCount => prevCount + users.length)
            })
            .leaving((user) => {
                const leaveMessage ={
                    has_leaved: true,
                    username: user.username
                }
                setMessages((prevMessages) => [...prevMessages, leaveMessage])
                setUserCount(prevCount => prevCount - 1)
                setUserTyping((names) => names.filter((name) => name !== user.username))
                setDoScroll(isScrollBottom())
            })
            .listen('.chat.general.post', (message) => {
                setMessages((prevMessages) => [...prevMessages, message])
                setSentMessages((sendingMessages) => sendingMessages.filter((item) => item.send_index !== message.index))
                setDoScroll(isScrollBottom())
            })
            .listenForWhisper('typing', (event) => {
                setUserTyping((names) => [...names, event.name])
            })
            .listenForWhisper('not.typing', (event) => {
                setUserTyping((names) => names.filter((name) => name !== event.name))
            })

    }, [])

    function isScrollBottom(){
        if(container.current?.scrollHeight - container.current?.offsetHeight === Math.round(container.current?.scrollTop)){
            return true
        }
        return false
    }

    function isContentValid(){
        return data.content !== '' && data.content.trim().length !== 0
    }

    useEffect(() => {
        if(doScroll === true){
            latestMessage.current?.scrollIntoView({
                block: "end",
            })
        }
    }, [messages, sentMessages])

    useEffect(() => {
        const channel = window.Echo.join('general-chat')
        
        if(isContentValid()){
            channel.whisper('typing', {
                name: guest.username
            })
        }
        else{
            channel.whisper('not.typing', {
                name: guest.username
            })
        }
    }, [isContentValid()])

    function handleSumbit(e){
        e.preventDefault()

        if(isContentValid()){
            setSendCounter(counter => counter + 1)
            setSentMessages((prevSentMessages) => [...prevSentMessages, data])
            setDoScroll(true)
            reset('content')
        }

        post('/chat/general')
    }

    function inputMessage(event){
        setData('content', event.target.value)
        if(data.send_index !== sendCounter){
            setData('send_index', sendCounter)
        }
    }

    function leaveChat(){
        window.Echo.leave('general-chat')
        router.get('/home')
    }

    return (
        <ChatLayout layoutStyle="min-w-[40rem] max-w-[40rem] min-h-[40rem] max-h-[40rem]">
            
            <ChatHeader 
                chatName="General Chat"
                onlineCount={userCount}
            >

                <CustomLink 
                    buttonStyle="text-xl text-green-700"
                    onLinkClick={() => leaveChat()}    
                >
                    Home
                </CustomLink>

            </ChatHeader>

            <ChatBox
                boxStyle="h-full min-h-[30rem] mb-3"
                infoRef={container}
                guestID={ guest.id }
                messageData={ messages }
                sendData={ sentMessages }
                bottomRef={ latestMessage }
            />

            <ChatFooter 
                onSend={ handleSumbit }
                value={ data.content }
                onInputChange={ e => inputMessage(e) }
                usersTyping={ userTyping }
            />

        </ChatLayout>
    )
}