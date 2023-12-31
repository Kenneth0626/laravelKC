import Layout from "./Layout/Layout";

export default function HelloWorld () {
    return(
        <Layout>
            <div className="bg-violet-500 border-4 border-indigo-800 w-fit h-fit rounded-lg m-auto drop-shadow-2xl overflow-x-auto">
                <h1 className="m-auto font-extrabold text-6xl p-8">
                    Hello World!
                </h1>
            </div>
        </Layout>      
    )
}