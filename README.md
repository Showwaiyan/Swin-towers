# Swin-towers
Towers Defense game with ruby for COS10009 Custom program assignment

## Tower Defense Game

## How to Install Ruby

1. **Download Ruby:**
   - Visit the [official Ruby website](https://www.ruby-lang.org/en/downloads/) to download Ruby for your operating system.

2. **Install Ruby:**
   - Follow the installation instructions provided for your platform (Windows, macOS, or Linux).
   - For Linux, you can also use a package manager, e.g., `sudo apt install ruby` on Ubuntu.

3. **Verify Installation:**
   - Open a terminal and type:
     ```bash
     ruby -v
     ```
   - This should display the installed Ruby version.

## How to Install Gosu

1. **Install Gosu Gem:**
   - Open a terminal and run the following command:
     ```bash
     gem install gosu
     ```

2. **Verify Installation:**
   - Run the following command:
     ```bash
     gem list gosu
     ```
   - This should display the installed version of Gosu.

## How to Launch the Game

1. **Download the Game Files:**
   - Clone the repository or download the ZIP file:
     ```bash
     git clone https://github.com/Showwaiyan/Swin-towers.git
     ```

2. **Navigate to the Game Directory:**
   - In the terminal, navigate to the folder where the game files are located:
     ```bash
     cd Swin-towers
     ```

3. **Run the Game:**
   - Execute the main Ruby file:
     ```bash
     ruby main.rb
     ```

## How to Configure and Customize

1. **Wave Customization:**
   - Edit the `waves<number>.txt` file in the game directory.
     - You can create a new wave by increasing last wave number or,
     - You can edit the wave based on existing wave file.
   - Specify enemy species.
   - Example format:
     ```
     orc
     bee
     hound
     slime
     ```

3. **Tower Settings:**
   - Open the `constant.rb` file to adjust tower attributes such as range, damage, and cost.

4. **Game Parameters:**
   - Edit the `constant.rb` file for global settings like screen resolution, starting currency, and difficulty scaling.

5. **Test Changes:**
   - Save your modifications and relaunch the game to see your customizations in action.

---

Enjoy defending your towers and customizing your gaming experience!
