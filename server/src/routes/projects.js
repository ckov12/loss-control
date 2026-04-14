const express = require('express');
const router = express.Router();
const { Project } = require('../models/project'); // Assume you have a Project model
const logger = require('../middlewares/logger'); // Middleware for logging

// POST - Create a new project
router.post('/', async (req, res) => {
    const { name, description, startDate, endDate } = req.body;
    const project = new Project({ name, description, startDate, endDate });
    await project.save();
    
    logger.info(`Project created: ${project._id}`); // Log creation
    res.status(201).send(project);
});

// GET - List all projects
router.get('/', async (req, res) => {
    const projects = await Project.find();
    res.send(projects);
});

// GET - Retrieve a specific project
router.get('/:id', async (req, res) => {
    const project = await Project.findById(req.params.id);
    if (!project) return res.status(404).send('Project not found.');
    res.send(project);
});

// PUT - Update a project
router.put('/:id', async (req, res) => {
    const { name, description, startDate, endDate } = req.body;
    const project = await Project.findByIdAndUpdate(req.params.id, { name, description, startDate, endDate }, { new: true });
    
    if (!project) return res.status(404).send('Project not found.');

    logger.info(`Project updated: ${project._id}`); // Log update
    res.send(project);
});

module.exports = router;