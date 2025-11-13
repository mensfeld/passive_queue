# ================================
# lib/passive_queue/web.rb
# ================================
require 'erb'
require 'json'

module PassiveQueue
  # Rack web application providing a dashboard interface for PassiveQueue
  class Web
    # Rack call method that routes requests to appropriate handlers
    #
    # @param env [Hash] Rack environment hash
    # @return [Array] Rack response triplet [status, headers, body]
    def call(env)
      request = Rack::Request.new(env)
      
      case request.path_info
      when '/'
        dashboard_response
      when '/api/stats'
        api_stats_response
      when '/api/zen'
        api_zen_response
      when '/favicon.ico'
        favicon_response
      when '/logo.svg'
        logo_response
      when '/logo-dark.svg'
        logo_dark_response
      else
        not_found_response
      end
    end

    private

    # Renders the main dashboard HTML page
    #
    # @return [Array] Rack response with HTML dashboard
    def dashboard_response
      html = dashboard_html
      [200, {'Content-Type' => 'text/html'}, [html]]
    end

    # Returns JSON response with queue statistics
    #
    # @return [Array] Rack response with JSON stats data
    def api_stats_response
      stats = {
        jobs_queued: rand(9999..99999),
        jobs_processed: 0,
        jobs_failed: 0,
        jobs_succeeded: "∞",
        uptime: "#{rand(1..999)} days of perfect inactivity",
        memory_usage: "0 MB",
        cpu_usage: "0%",
        queue_names: ["default", "mailers", "active_storage", "imports", "exports"].sample(rand(2..5)),
        processing_time: "0ms",
        success_rate: "100%",
        zen_level: ["Transcendent", "Enlightened", "Peaceful", "Serene"].sample
      }
      [200, {'Content-Type' => 'application/json'}, [stats.to_json]]
    end

    # Returns JSON response with a random zen quote
    #
    # @return [Array] Rack response with JSON zen quote
    def api_zen_response
      quote = PassiveQueue.zen_quotes.sample
      [200, {'Content-Type' => 'application/json'}, [{quote: quote}.to_json]]
    end

    # Returns CSS stylesheet response (unused method)
    #
    # @return [Array] Rack response with CSS content
    def css_response
      css = dashboard_css
      [200, {'Content-Type' => 'text/css'}, [css]]
    end

    # Returns the light theme logo SVG
    #
    # @return [Array] Rack response with SVG logo
    def logo_response
      svg = logo_svg
      [200, {'Content-Type' => 'image/svg+xml'}, [svg]]
    end

    # Returns the dark theme logo SVG
    #
    # @return [Array] Rack response with dark theme SVG logo
    def logo_dark_response
      svg = logo_svg_dark
      [200, {'Content-Type' => 'image/svg+xml'}, [svg]]
    end

    # Returns an empty favicon response
    #
    # @return [Array] Rack response with empty favicon
    def favicon_response
      # Return empty response for favicon
      [200, {'Content-Type' => 'image/x-icon'}, ['']]
    end

    # Returns a 404 not found response with zen humor
    #
    # @return [Array] Rack response with 404 HTML
    def not_found_response
      [404, {'Content-Type' => 'text/html'}, ['<h1>404 - Page Not Found (Just Like Our Jobs)</h1>']]
    end

    # Reads and returns the light theme logo SVG content
    #
    # @return [String] SVG file contents
    def logo_svg
     logo_path = File.join(File.dirname(__FILE__), '..', '..', 'html', 'logo.svg')
     File.read(logo_path)
    end

    # Reads and returns the dark theme logo SVG content
    #
    # @return [String] dark theme SVG file contents
    def logo_svg_dark
     logo_path = File.join(File.dirname(__FILE__), '..', '..', 'html', 'logo-dark.svg')
     File.read(logo_path)
    end

    # Generates and returns the complete dashboard HTML
    #
    # @return [String] HTML content for the dashboard page
    def dashboard_html
      <<~HTML
        <!DOCTYPE html>
        <html lang="en" data-theme="light">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Passive Queue Dashboard - The Art of Non-Execution</title>
            <link rel="icon" href="/passive_queue/logo.svg" type="image/svg+xml">

            <script>
                (function() {
                    // Get saved theme or default to auto
                    const savedTheme = localStorage.getItem('theme');
                    const themeToApply = savedTheme !== null ? savedTheme : 'auto';
                    
                    function getSystemTheme() {
                        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
                    }
                    
                    let actualTheme;
                    if (themeToApply === 'auto') {
                        actualTheme = getSystemTheme();
                    } else {
                        actualTheme = themeToApply;
                    }
                    
                    // Apply theme immediately to prevent flash
                    document.documentElement.setAttribute('data-theme', actualTheme);
                    
                    // Store current preference for later use
                    window.currentThemePreference = themeToApply;
                })();
            </script>
            
            <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
            <link href="https://cdn.jsdelivr.net/npm/daisyui@5/themes.css" rel="stylesheet" type="text/css" />
            <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
            
            <style>
                body { font-family: 'Inter', sans-serif; }
                
                /* Light mode gradients and shadows (default) */
                .zen-gradient { 
                    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%); 
                }
                .peaceful-shadow { 
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05); 
                }
                
                /* Dark mode variations */
                [data-theme="dark"] .zen-gradient { 
                    background: linear-gradient(135deg, #1f2937 0%, #111827 100%); 
                }
                [data-theme="dark"] .peaceful-shadow { 
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); 
                }
                
                /* Animations remain the same */
                .loading-dots::after {
                    content: '';
                    animation: dots 2s infinite;
                }
                @keyframes dots {
                    0%, 20% { content: '.'; }
                    40% { content: '..'; }
                    60% { content: '...'; }
                    80%, 100% { content: ''; }
                }
                .float { animation: float 6s ease-in-out infinite; }
                @keyframes float {
                    0%, 100% { transform: translateY(0px); }
                    50% { transform: translateY(-10px); }
                }
                
                .pulse-zen { animation: pulse-zen 3s ease-in-out infinite; }
                @keyframes pulse-zen {
                    0%, 100% { opacity: 1; }
                    50% { opacity: 0.7; }
                }
                
                /* Theme toggle button styles */
                .theme-toggle {
                    display: none;
                    width: 48px;
                    height: 24px;
                    background: var(--fallback-b2,oklch(var(--b2)));
                    border-radius: 12px;
                    border: 2px solid var(--fallback-bc,oklch(var(--bc)/0.2));
                    cursor: pointer;
                    position: relative;
                    transition: all 0.3s ease;
                }

                .theme-toggle::before {
                    content: '';
                    position: absolute;
                    top: 50%;
                    left: 2px;
                    transform: translateY(-50%);
                    font-size: 14px;
                    transition: all 0.3s ease;
                }

                [data-theme="dark"] .theme-toggle::before {
                    content: '';
                    left: 22px;
                }

                .theme-toggle::after {
                    content: '';
                    position: absolute;
                    top: 2px;
                    left: 2px;
                    width: 16px;
                    height: 16px;
                    background: var(--fallback-bc,oklch(var(--bc)));
                    border-radius: 50%;
                    transition: all 0.3s ease;
                }

                [data-theme="dark"] .theme-toggle::after {
                    transform: translateX(20px);
                }
            </style>
        </head>
        <body class="zen-gradient min-h-screen">
            <!-- Navigation -->
            <div class="navbar bg-base-100/80 backdrop-blur-sm peaceful-shadow">
                <div class="navbar-start">
                    <a class="btn btn-ghost text-xl font-light">
                        <!-- Light mode logo -->
                        <img src="/passive_queue/logo.svg" alt="Passive Queue Logo" 
                             class="w-7 h-7 mr-2 logo-light">
                        <!-- Dark mode logo -->
                        <img src="/passive_queue/logo-dark.svg" alt="Passive Queue Logo" 
                             class="w-7 h-7 mr-2 hidden logo-dark">
                        Passive Queue Dashboard
                    </a>
                </div>
                <div class="navbar-center">
                    <div class="badge badge-success badge-lg">
                        <span class="loading loading-ring loading-xs mr-1"></span>
                        Non-Processing
                    </div>
                </div>
                <div class="navbar-end">
                    <!-- Theme Toggle -->
                    <div class="flex items-center gap-2 mr-4">
                        <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme"></button>
                        <div class="dropdown dropdown-end z-[100]">
                            <div tabindex="0" role="button" class="btn btn-ghost btn-sm">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
                                </svg>
                            </div>
                            <ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52 z-50 z-[100]">
                                <li><a onclick="setTheme('light')">☀️ Light Mode</a></li>
                                <li><a onclick="setTheme('dark')">🌙 Dark Mode</a></li>
                                <li><a onclick="setTheme('auto')">🔄 Auto (System)</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Dashboard -->
            <div class="container mx-auto px-4 py-8">
                <!-- Hero Stats -->
                <div class="stats stats-vertical lg:stats-horizontal shadow w-full mb-8 bg-base-100 peaceful-shadow">
                    <div class="stat">
                        <div class="stat-figure text-primary">
                            <div class="text-3xl float">📊</div>
                        </div>
                        <div class="stat-title">Jobs Queued</div>
                        <div class="stat-value text-primary" id="jobs-queued">∞</div>
                        <div class="stat-desc">All waiting peacefully</div>
                    </div>
                    
                    <div class="stat">
                        <div class="stat-figure text-secondary">
                            <div class="text-3xl pulse-zen">✨</div>
                        </div>
                        <div class="stat-title">Jobs Processed</div>
                        <div class="stat-value text-secondary" id="jobs-processed">0</div>
                        <div class="stat-desc">Perfect execution rate</div>
                    </div>
                    
                    <div class="stat">
                        <div class="stat-figure text-accent">
                            <div class="text-3xl">⏱️</div>
                        </div>
                        <div class="stat-title">Avg Processing Time</div>
                        <div class="stat-value text-accent" id="processing-time">0ms</div>
                        <div class="stat-desc">Blazing fast non-execution</div>
                    </div>
                    
                    <div class="stat">
                        <div class="stat-figure text-success">
                            <div class="text-3xl">🎯</div>
                        </div>
                        <div class="stat-title">Success Rate</div>
                        <div class="stat-value text-success" id="success-rate">100%</div>
                        <div class="stat-desc">At doing nothing</div>
                    </div>
                </div>

                <div class="grid lg:grid-cols-2 gap-8 mb-8">
                    <!-- Queue Status -->
                    <div class="card bg-base-100 peaceful-shadow">
                        <div class="card-body">
                            <h2 class="card-title">
                                <span class="text-2xl mr-2">📋</span>
                                Queue Status
                            </h2>
                            
                            <div class="space-y-4">
                                <div class="flex justify-between items-center">
                                    <span class="font-medium">Active Queues</span>
                                    <div class="badge badge-info" id="active-queues">5</div>
                                </div>
                                
                                <div class="space-y-2" id="queue-list">
                                    <!-- Queues will be populated by JavaScript -->
                                </div>
                            </div>
                            
                            <div class="card-actions justify-end mt-4">
                                <button class="btn btn-sm btn-outline" onclick="refreshQueues()">
                                    <span class="loading loading-spinner loading-xs mr-1 hidden" id="refresh-spinner"></span>
                                    Refresh
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- System Status -->
                    <div class="card bg-base-100 peaceful-shadow">
                        <div class="card-body">
                            <h2 class="card-title">
                                <span class="text-2xl mr-2">💻</span>
                                System Status
                            </h2>
                            
                            <div class="space-y-4">
                                <div class="flex justify-between items-center">
                                    <span>Memory Usage</span>
                                    <div class="text-right">
                                        <div class="text-sm font-mono" id="memory-usage">0 MB</div>
                                        <progress class="progress progress-success w-24" value="0" max="100"></progress>
                                    </div>
                                </div>
                                
                                <div class="flex justify-between items-center">
                                    <span>CPU Usage</span>
                                    <div class="text-right">
                                        <div class="text-sm font-mono" id="cpu-usage">0%</div>
                                        <progress class="progress progress-success w-24" value="0" max="100"></progress>
                                    </div>
                                </div>
                                
                                <div class="flex justify-between items-center">
                                    <span>Uptime</span>
                                    <div class="text-sm font-mono" id="uptime">∞ days</div>
                                </div>
                                
                                <div class="flex justify-between items-center">
                                    <span>Zen Level</span>
                                    <div class="badge badge-primary" id="zen-level">Transcendent</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Zen Quotes Section -->
                <div class="card bg-base-100 peaceful-shadow mb-8">
                    <div class="card-body text-center">
                        <h2 class="card-title justify-center">
                            <span class="text-2xl mr-2">🧘‍♂️</span>
                            Daily Zen
                        </h2>
                        
                        <div class="max-w-2xl mx-auto">
                            <blockquote class="text-lg italic text-base-content/80 mb-4" id="zen-quote">
                                "Loading wisdom..."
                            </blockquote>
                            
                            <button class="btn btn-primary btn-sm" onclick="getNewZenQuote()">
                                New Wisdom
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Recent Non-Activity -->
                <div class="card bg-base-100 peaceful-shadow">
                    <div class="card-body">
                        <h2 class="card-title">
                            <span class="text-2xl mr-2">📝</span>
                            Recent Non-Activity
                        </h2>
                        
                        <div class="overflow-x-auto">
                            <table class="table table-zebra">
                                <thead>
                                    <tr>
                                        <th>Job ID</th>
                                        <th>Queue</th>
                                        <th>Class</th>
                                        <th>Status</th>
                                        <th>Non-Executed At</th>
                                    </tr>
                                </thead>
                                <tbody id="recent-jobs">
                                    <!-- Jobs will be populated by JavaScript -->
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="text-center mt-4">
                            <div class="text-sm text-base-content/60">
                                All jobs are successfully not being processed 🎯
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- JavaScript -->
            <script>
                function updateLogos() {
                    // Check the actual applied theme instead of system preference
                    const currentTheme = document.documentElement.getAttribute('data-theme');
                    const lightLogos = document.querySelectorAll('.logo-light');
                    const darkLogos = document.querySelectorAll('.logo-dark');

                    if (currentTheme === 'dark') {
                        lightLogos.forEach(logo => logo.classList.add('hidden'));
                        darkLogos.forEach(logo => logo.classList.remove('hidden'));
                    } else {
                        lightLogos.forEach(logo => logo.classList.remove('hidden'));
                        darkLogos.forEach(logo => logo.classList.add('hidden'));
                    }
                }

                // Theme management system
                let currentThemePreference = 'auto'; // Track current preference

                function getSystemTheme() {
                    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
                }

                function applyTheme(theme) {
                    currentThemePreference = theme;
                    
                    if (theme === 'auto') {
                        const systemTheme = getSystemTheme();
                        document.documentElement.setAttribute('data-theme', systemTheme);
                        return systemTheme;
                    } else {
                        document.documentElement.setAttribute('data-theme', theme);
                        return theme;
                    }
                }

                function setTheme(theme) {
                    localStorage.setItem('theme', theme);
                    applyTheme(theme);
                    updateLogos();
                }

                function toggleTheme() {
                    const themes = ['light', 'dark', 'auto'];
                    const currentIndex = themes.indexOf(currentThemePreference);
                    const nextTheme = themes[(currentIndex + 1) % themes.length];
                    setTheme(nextTheme);
                }

                function initTheme() {
                    // Get saved theme or default to auto
                    const savedTheme = localStorage.getItem('theme');
                    const themeToApply = savedTheme !== null ? savedTheme : 'auto';
                    
                    applyTheme(themeToApply);
                    
                    // Listen for system theme changes
                    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
                        if (currentThemePreference === 'auto') {
                            applyTheme('auto');
                            updateLogos();
                        }
                    });

                    updateLogos();
                }
                
                async function loadStats() {
                    try {
                        const response = await fetch('/passive_queue/api/stats');
                        const stats = await response.json();
                        
                        document.getElementById('jobs-queued').textContent = stats.jobs_queued.toLocaleString();
                        document.getElementById('jobs-processed').textContent = stats.jobs_processed;
                        document.getElementById('processing-time').textContent = stats.processing_time;
                        document.getElementById('success-rate').textContent = stats.success_rate;
                        document.getElementById('memory-usage').textContent = stats.memory_usage;
                        document.getElementById('cpu-usage').textContent = stats.cpu_usage;
                        document.getElementById('uptime').textContent = stats.uptime;
                        document.getElementById('zen-level').textContent = stats.zen_level;
                        
                        // Update queue list
                        const queueList = document.getElementById('queue-list');
                        queueList.innerHTML = stats.queue_names.map(queue => 
                            `<div class="flex justify-between items-center">
                                <span class="text-sm">${queue}</span>
                                <div class="badge badge-ghost badge-sm">0 processing</div>
                            </div>`
                        ).join('');
                        
                        document.getElementById('active-queues').textContent = stats.queue_names.length;
                        
                    } catch (error) {
                        console.error('Failed to load stats:', error);
                    }
                }
                
                async function getNewZenQuote() {
                    try {
                        const response = await fetch('/passive_queue/api/zen');
                        const data = await response.json();
                        document.getElementById('zen-quote').textContent = data.quote;
                    } catch (error) {
                        console.error('Failed to load zen quote:', error);
                    }
                }
                
                function refreshQueues() {
                    const spinner = document.getElementById('refresh-spinner');
                    spinner.classList.remove('hidden');
                    
                    setTimeout(() => {
                        loadStats();
                        spinner.classList.add('hidden');
                    }, 1000);
                }
                
                function generateRecentJobs() {
                    const jobClasses = ['UserMailer', 'DataProcessor', 'ImageResizer', 'ReportGenerator', 'BackupJob'];
                    const queues = ['default', 'mailers', 'critical', 'background'];
                    const tbody = document.getElementById('recent-jobs');
                    
                    const jobs = Array.from({length: 10}, (_, i) => {
                        const jobId = `passive-${Date.now() + i}`;
                        const queue = queues[Math.floor(Math.random() * queues.length)];
                        const jobClass = jobClasses[Math.floor(Math.random() * jobClasses.length)];
                        const time = new Date(Date.now() - Math.random() * 3600000);
                        
                        return `
                            <tr>
                                <td><code class="text-xs">${jobId}</code></td>
                                <td><span class="badge badge-outline badge-xs">${queue}</span></td>
                                <td>${jobClass}</td>
                                <td><div class="badge badge-success badge-xs">Not Processed</div></td>
                                <td class="text-xs">${time.toLocaleString()}</td>
                            </tr>
                        `;
                    });
                    
                    tbody.innerHTML = jobs.join('');
                }
                
                // Initialize dashboard
                document.addEventListener('DOMContentLoaded', function() {
                    initTheme();
                    loadStats();
                    getNewZenQuote();
                    generateRecentJobs();
                    
                    // Auto-refresh every 30 seconds
                    setInterval(loadStats, 30000);
                    
                    // Change zen quote every 2 minutes
                    setInterval(getNewZenQuote, 120000);
                });
                
                // Run theme init immediately to prevent flash
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', initTheme);
                } else {
                    initTheme();
                }
                
                // Easter egg: Add some zen to the console
                console.log('🧘 Welcome to the Passive Queue Dashboard');
                console.log('💭 Remember: The best job is the one never executed');
                console.log('✨ Achievement unlocked: 100% success rate at doing nothing');
            </script>
        </body>
        </html>
      HTML
    end
  end
end

# ================================
# lib/passive_queue/engine.rb  
# ================================
module PassiveQueue
  class Engine
    def self.call(env)
      # Strip the mount path to get relative path
      path_info = env['PATH_INFO']
      script_name = env['SCRIPT_NAME']
      
      # Create new env with adjusted paths for the Web app
      web_env = env.dup
      web_env['PATH_INFO'] = path_info
      web_env['SCRIPT_NAME'] = script_name
      
      Web.new.call(web_env)
    end
  end
end

# ================================
# Usage in Rails routes.rb:
# ================================
# Rails.application.routes.draw do
#   mount PassiveQueue::Engine => '/passive_queue'
# end