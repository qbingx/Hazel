workspace "Hazel"
	architecture "x86_64"
	startproject "Sandbox"


	configurations 
	{
		"Debug",
		"Release",	
		"Dist",
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"	

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


	files 
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs 
	{
		"%{prj.name}/vendor/spdlog/include"			
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "on"
		systemversion "10.0.17763.0"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		postbuildcommands 
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" ..outputdir.. "/Sandbox")
		}
		
	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "on"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "on"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "on"
			
project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"	

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files 
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs 
	{
		"Hazel/vendor/spdlog/include",
		"Hazel/src"
	}

	links
	{
		"Hazel"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "on"
		systemversion "10.0.17763.0"

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "on"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "on"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "on"