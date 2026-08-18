import { BrowserRouter, Route, Routes } from "react-router";
import ListRequests from "./pages/ListRequests";
import ShowRequest from "./pages/ShowRequest";

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route index element={<ListRequests />} />
                <Route path="requests/:reqId" element={<ShowRequest />} />
            </Routes>
        </BrowserRouter>
    );
}

export default App;
