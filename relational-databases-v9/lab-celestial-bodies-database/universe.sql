--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id bigint NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    has_life boolean,
    age_in_millions_of_years integer NOT NULL,
    distance_from_earth integer NOT NULL,
    older_than_milkyway_galaxy boolean NOT NULL,
    major_axis_diameter_in_kiloparsecs numeric(5,2) NOT NULL,
    CONSTRAINT galaxy_distance_from_earth_check CHECK ((distance_from_earth >= 0))
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.galaxy ALTER COLUMN galaxy_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.galaxy_galaxy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    has_life boolean,
    age_in_millions_of_years integer NOT NULL,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.moon ALTER COLUMN moon_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.moon_moon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    has_life boolean,
    age_in_millions_of_years integer NOT NULL,
    planet_type_id integer NOT NULL,
    has_water boolean,
    star_id bigint NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.planet ALTER COLUMN planet_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.planet_planet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: planet_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_type (
    planet_type_id integer NOT NULL,
    name character varying(100) NOT NULL,
    characteristics text
);


ALTER TABLE public.planet_type OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.planet_type ALTER COLUMN planet_type_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.planet_type_planet_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    has_life boolean,
    age_in_millions_of_years integer NOT NULL,
    galaxy_id integer NOT NULL,
    star_type_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.star ALTER COLUMN star_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.star_star_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: star_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star_type (
    star_type_id integer NOT NULL,
    name character varying(30) NOT NULL,
    characteristics character varying(255),
    color character varying(100) NOT NULL,
    temperature_in_kelvin bigint NOT NULL
);


ALTER TABLE public.star_type OWNER TO freecodecamp;

--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.star_type ALTER COLUMN star_type_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.star_type_star_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (1, 'Milky Way', 'Humanity''s first home', true, 13600, 0, false, 26.80);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (2, 'Andromeda Galaxy', 'Named after the princess who was the wife of Perseus in Greek mythology', NULL, 7500, 2500000, false, 46.56);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (3, 'Triangulum Galaxy', 'The galaxy gets its name from the constellation Triangulum, where it can be spotted', NULL, 4, 2878000, false, 18.73);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (4, 'Large Magellanic Cloud', 'The first confirmed recorded observation was in a letter written in 1502 by Amerigo Vespucci after his second voyage', NULL, 6000, 163000, false, 9.86);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (5, 'Wolf–Lundmark–Melotte', 'The discovery of the nature of the galaxy was accredited to Knut Lundmark and Philibert Jacques Melotte in 1926', NULL, 15000, 2153000, true, 5.52);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (6, 'Pisces Dwarf', 'It is approaching the Milky Way at 287 km/s', NULL, 100, 19000000, false, 2.51);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (1, 'Mimas', 'Seventh-largest natural satellite', false, 4500, 18);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (2, 'Enceladus', 'It is covered by clean, freshly deposited snow hundreds of meters thick', false, 1000, 18);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (3, 'Tethys', 'Tethys has a low density of 0.98 g/cm3, the lowest of all the major moons in the Solar System', false, 1006, 18);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (4, 'Dione', 'Dione is composed of an icy mantle and crust overlying a silicate rocky core', false, 4000, 18);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (5, 'Rhea', 'Rhea is the smallest body in the Solar System that is confirmed to be in hydrostatic equilibrium', false, 4000, 18);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (6, 'Titan', 'The only moon known to have a dense atmosphere—denser than Earth''s', false, 4500, 18);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (7, 'Iapetus', 'Iapetus is home to several distinctive and unusual features, such as a striking difference in coloration between its dark leading hemisphere and its bright trailing hemisphere', false, 4500, 18);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (8, 'Miranda', 'Its total surface area is roughly equal to that of the U.S. state of Texas', false, 4500, 19);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (9, 'Io', 'It has the highest density and strongest surface gravity of any natural satellite', false, 4500, 17);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (10, 'Moon', 'The Latin name for the Moon is lūna', false, 4510, 15);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (11, 'Triton', 'It is the only moon of Neptune massive enough to be rounded under its own gravity', false, 4500, 20);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (12, 'Titania', 'Titania consists of approximately equal amounts of ice and rock', false, 4600, 19);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (13, 'Oberon', 'Named after the mythical king of the fairies who appears as a character in Shakespeare''s A Midsummer Night''s Dream', false, 4500, 19);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (14, 'Umbriel', 'The surface is the darkest among Uranian moons and appears to have been shaped primarily by impacts', false, 4500, 19);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (15, 'Ariel', 'Ariel orbits and rotates in Uranus''s equatorial plane, which is almost perpendicular to the planet''s orbit, giving the moon an extreme seasonal cycle', false, 4500, 19);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (16, 'Puck', 'The name Puck follows the convention of naming Uranus''s moons after characters from Shakespeare''s Midsummer Night''s Dream', false, 4500, 19);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (17, 'Desdemona', 'Little is known about Desdemona', false, 4500, 19);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (18, 'Ganymede', 'The largest and most massive moon in the Solar System', false, 4500, 17);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (19, 'Callisto', 'The surface of Callisto is the oldest and most heavily cratered in the Solar System', false, 4500, 17);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (20, 'Europa', 'It is observable from Earth with common binoculars', false, 4500, 17);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (13, 'Mercury', 'The smallest planet in the Solar System and closest to the Sun', false, 4503, 1, false, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (14, 'Venus', 'The hottest planet in the Solar System with a thick toxic atmosphere', false, 4503, 1, false, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (15, 'Earth', 'The only known planet to harbor life', true, 4543, 1, true, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (16, 'Mars', 'Known as the Red Planet due to iron oxide on its surface', false, 4603, 1, false, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (17, 'Jupiter', 'The largest planet in the Solar System, a gas giant', false, 4603, 2, false, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (18, 'Saturn', 'A gas giant known for its prominent ring system', false, 4503, 2, false, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (19, 'Uranus', 'An ice giant that rotates on its side', false, 4503, 3, false, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (20, 'Neptune', 'The farthest known planet from the Sun, an ice giant', false, 4503, 3, false, 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (21, 'Proxima Centauri b', 'An exoplanet orbiting within the habitable zone of Proxima Centauri', false, 4850, 1, false, 5);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (22, 'Kepler-442b', 'A super-Earth exoplanet in the habitable zone of its star', false, 2900, 1, false, 6);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (23, 'TRAPPIST-1e', 'A rocky exoplanet in the habitable zone of the TRAPPIST-1 system', false, 7600, 1, false, 7);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (24, 'TRAPPIST-1f', 'A rocky exoplanet orbiting TRAPPIST-1, potentially habitable', false, 7600, 1, false, 8);


--
-- Data for Name: planet_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_type OVERRIDING SYSTEM VALUE VALUES (1, 'Terrestrial', 'Rocky surface, relatively small size, high density, few or no moons');
INSERT INTO public.planet_type OVERRIDING SYSTEM VALUE VALUES (2, 'Gas Giant', 'Mostly hydrogen and helium, no solid surface, large size, many moons');
INSERT INTO public.planet_type OVERRIDING SYSTEM VALUE VALUES (3, 'Ice Giant', 'High proportion of water, ammonia and methane ices, thick atmosphere');
INSERT INTO public.planet_type OVERRIDING SYSTEM VALUE VALUES (4, 'Exoplanet', 'Orbits a star outside the Solar System, diverse characteristics');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (4, 'Sun', 'A G-type main-sequence star at the center of the Solar System', false, 4600, 1, 5);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (5, 'Proxima Centauri', 'A red dwarf star and the closest known star to the Sun', false, 4850, 1, 7);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (6, 'Kepler-442', 'A K-type star hosting the confirmed exoplanet Kepler-442b', false, 2900, 1, 6);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (7, 'TRAPPIST-1', 'An ultracool red dwarf star hosting seven known rocky planets', false, 7600, 1, 7);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (8, 'Sirius', 'The brightest star in the night sky; a white main-sequence star in the Milky Way', false, 242, 1, 3);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (9, 'Betelgeuse', 'A red supergiant star in the constellation Orion, nearing the end of its stellar evolution', false, 10, 1, 7);


--
-- Data for Name: star_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star_type OVERRIDING SYSTEM VALUE VALUES (1, 'O', 'Very hot, very luminous, blue supergiants; rare but extremely bright', 'Blue', 30000);
INSERT INTO public.star_type OVERRIDING SYSTEM VALUE VALUES (2, 'B', 'Hot and luminous, blue-white stars', 'Blue-White', 10000);
INSERT INTO public.star_type OVERRIDING SYSTEM VALUE VALUES (3, 'A', 'White or blue-white stars, strong hydrogen lines', 'White', 7500);
INSERT INTO public.star_type OVERRIDING SYSTEM VALUE VALUES (4, 'F', 'Yellow-white stars, slightly hotter than the Sun', 'Yellow-White', 6000);
INSERT INTO public.star_type OVERRIDING SYSTEM VALUE VALUES (5, 'G', 'Yellow stars, similar to the Sun; moderate temperature', 'Yellow', 5200);
INSERT INTO public.star_type OVERRIDING SYSTEM VALUE VALUES (6, 'K', 'Orange stars, cooler than the Sun', 'Orange', 3900);
INSERT INTO public.star_type OVERRIDING SYSTEM VALUE VALUES (7, 'M', 'Red dwarfs, coolest and most common type of star', 'Red', 2400);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 24, true);


--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_type_planet_type_id_seq', 4, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 9, true);


--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_type_star_type_id_seq', 7, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet_type planet_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_name_key UNIQUE (name);


--
-- Name: planet_type planet_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_pkey PRIMARY KEY (planet_type_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star_type star_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_name_key UNIQUE (name);


--
-- Name: star_type star_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_pkey PRIMARY KEY (star_type_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_planet_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_type_id_fkey FOREIGN KEY (planet_type_id) REFERENCES public.planet_type(planet_type_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star star_star_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_type_id_fkey FOREIGN KEY (star_type_id) REFERENCES public.star_type(star_type_id);


--
-- PostgreSQL database dump complete
--

