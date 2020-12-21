function getRoleColor(role) {
    switch(role) {
    case 0: case "Team Leader":
        return "yellow";
    case 1: case "Developer":
        return "blue";
    case 2: case "BA":
        return "red";
    case 3: case "Tester":
        return "green";
    }
}
