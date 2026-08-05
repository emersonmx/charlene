import { useState } from "react";

function App() {
    const [count, setCount] = useState(0);

    return (
        <section className="flex min-h-screen flex-col items-center justify-center bg-gray-100 text-gray-700">
            <button
                type="button"
                className="rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700"
                onClick={() => {
                    setCount((count) => count + 1);
                }}
            >
                Count is {count}
            </button>
        </section>
    );
}

export default App;
