import { useEffect, useState } from "react";

function App() {
  const [message, setMessage] = useState("Loading...");
  const [dbStatus, setDbStatus] = useState("Checking...");

  useEffect(() => {
    fetch("/api/health")
      .then((response) => response.json())
      .then((data) => {
        setMessage(data.message);
        setDbStatus(data.database);
      })
      .catch(() => {
        setMessage("Backend unavailable");
        setDbStatus("Unknown");
      });
  }, []);

  return (
    <div style={{ padding: "40px", fontFamily: "Arial" }}>
      <h1>3-Tier AKS Application</h1>

      <h2>React Frontend</h2>

      <p>
        <strong>Backend:</strong> {message}
      </p>

      <p>
        <strong>Database:</strong> {dbStatus}
      </p>
    </div>
  );
}

export default App;