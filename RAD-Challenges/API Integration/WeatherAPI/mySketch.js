let weatherData;
const apiKey = '3f050a2f8ffa6bef3402fbb6f638c230'; // Replace with your actual API key
const units = 'imperial'; // Use 'imperial' for Fahrenheit
const apiUrl = `https://api.openweathermap.org/data/2.5/weather?q=New York&appid=${apiKey}&units=imperial`;

function setup() {
    createCanvas(400, 400); // Increased height to fit date display
    textSize(16);
    textAlign(CENTER, CENTER);
    fetchWeather();
    setInterval(fetchWeather, 600000); // Update every 10 minutes
}

function draw() {
    background(0);
    fill(255);

    if (weatherData && weatherData.main) {  
        const { temp, humidity, temp_min, temp_max } = weatherData.main;  
        const description = weatherData.weather?.[0]?.description || "No description available"; 

        // Convert Unix timestamp to readable date format
        const date = new Date(weatherData.dt * 1000); // Convert from seconds to milliseconds
        const dateString = date.toLocaleDateString("en-US", { 
            weekday: "long", year: "numeric", month: "long", day: "numeric" 
        });

        text(`Date: ${dateString}`, 200, 130);
        text(`NYC Weather: ${description}`, 200, 150);
        text(`Temperature: ${temp} °F`, 200, 170);
        text(`Min Temp: ${temp_min} °F`, 200, 190);
        text(`Max Temp: ${temp_max} °F`, 200, 210);
        text(`Humidity: ${humidity}%`, 200, 230);
    } else {
        text("Loading weather data...", 200, 240);
    }
}

function fetchWeather() {
    loadJSON(apiUrl, (data) => {
        weatherData = data;
        print(data); // Debugging: Log the full API response
    }, (error) => {
        console.error('Error fetching weather data:', error);
    });
}